<p style="text-align: center;">
  <img src="img/graphx_logo.png"
       title="GraphX Logo"
       alt="GraphX"
       width="65%" />
  <!-- Images are downsized intentionally to improve quality on retina displays -->
</p>

<!-- In this chapter we use GraphX to analyze Wikipedia data and implement graph algorithms in Spark. As with other exercises we will work with a subset of the Wikipedia traffic statistics data from May 5-7, 2009. In particular, this dataset only includes a subset of all Wikipedia articles. -->

<!---
GraphX is the new Spark API for graphs (e.g., Web-Graphs and Social Networks) and graph-parallel computation (e.g., PageRank and Collaborative Filtering).
At a high-level, GraphX extends the Spark RDD abstraction by introducing the [Resilient Distributed Property Graph](#property_graph): a directed multigraph with properties attached to each vertex and edge.
To support graph computation, GraphX exposes a set of fundamental operators (e.g., [subgraph](#structural_operators), [joinVertices](#join_operators), and [mapReduceTriplets](#mrTriplets)) as well as an optimized variant of the [Pregel](#pregel) API.
In addition, GraphX includes a growing collection of graph [algorithms](#graph_algorithms) and
[builders](#graph_builders) to simplify graph analytics tasks.

In this chapter we use GraphX to analyze Wikipedia data and implement graph algorithms in Spark.
The GraphX API is currently only available in Scala but we plan to provide Java and Python bindings in the future.
-->
## Getting Started

Because GraphX is a new addition to Spark, there is no Python API for it yet. This means you need to program in Scala to use GraphX.

We will be using the Spark shell for this assignment, which is a modified Scala REPL (Read-Eval-Print Loop). You will be running Spark locally on your laptop for this assignment.

__Note__: There are some exercises in this lab that require you to write code in the Spark shell. We recommend that you use a text-editor to write the code, and then once you think you have it working copy and paste it into the shell. This way, if you have a syntax error or something goes wrong (e.g. you accidentally exit the shell), you will have all your work saved.

Before you start Spark, there are a few settings to update.

In the `lab10/` directory of the GitHub repository for the class there are two files, `spark-env.sh` and `log4j.properties`. Copy these two files into the the `/conf` subdirectory of your Spark installation.

For example, if the root of my Spark directory is `/home/saasbook/spark-0.9.1-bin-cdh4`, I would do:

```bash
cp /home/saasbook/datascience-labs/lab10/{spark-env.sh,log4j.properties} /home/saasbook/spark-0.9.1-bin-cdh4/conf/
```

The `log4j.properties` file changes the default logging setting from `INFO` to `WARN`, which will remove some of the more verbose Spark logging messages. The `spark-env.sh` file specifies a custom serializer for Spark to use and some additional settings for serialization. These are necessary for GraphX to properly serialize and deserialize its data structures.


## Introduction to the Scala shell

This section is a quick crash course in Scala and the Scala shell and introduce you to functional programming with collections.
If you have never programmed in Scala before, we recommend working through these as a gentle introduction to Scala in a REPL, but if you are already familiar with Scala you can skip to the next section.

This exercise is based on a great tutorial, <a href="http://www.artima.com/scalazine/articles/steps.html" target="_blank">First Steps to Scala</a>.
However, reading through that whole tutorial and trying the examples at the console may take considerable time, so we will provide a basic introduction to the Scala shell here. Do as much as you feel you need (in particular you might want to skip the final "bonus" question).

For the remainder of this lab, we will use the convention that `SPARK_HOME` refers to the root of your Spark directory. For example, in the saasbook VM `SPARK_HOME=/home/saasbook/spark-0.9.1-bin-cdh4'

1. Launch the Spark REPL by typing:

   ```
   SPARK_HOME/bin/spark-shell
   ```

1. Declare a list of integers as a variable called "myNumbers".

   ```scala
   val myNumbers = List(1, 2, 5, 4, 7, 3)
   ```

1. Declare a function, `cube`, that computes the cube (third power) of an Int.
   See steps 2-4 of First Steps to Scala.
   
   ```scala
   def cube(a: Int): Int = a * a * a
   ```
   
1. Apply the function to `myNumbers` using the `map` function. Hint: read about the `map` function in <a href="http://www.scala-lang.org/api/current/index.html#scala.collection.immutable.List" target="_blank">the Scala List API</a> and also in Table 1 about halfway through the <a href="http://www.artima.com/scalazine/articles/steps.html" target="_blank">First Steps to Scala</a> tutorial.

   ```scala
   myNumbers.map(x => cube(x))
   // res: List[Int] = List(1, 8, 125, 64, 343, 27)
   // Scala also provides some shorthand ways of writing this:
   myNumbers.map(cube(_))
   // and
   myNumbers.map(cube)
   ```

1. Then also try writing the function inline in a `map` call, using closure notation.

  ```scala
  myNumbers.map{x => x * x * x}
  //res: List[Int] = List(1, 8, 125, 64, 343, 27)
  ```

1. Define a `factorial` function that computes n! = 1 * 2 * ... * n given input n.
   You can use either a loop or recursion, in our solution we use recursion (see steps 5-7 of <a href="http://www.artima.com/scalazine/articles/steps.html" target="_blank">First Steps to Scala</a>).
   Then compute the sum of factorials in `myNumbers`. Hint: check out the `sum` function in <a href="http://www.scala-lang.org/api/current/index.html#scala.collection.immutable.List" target="_blank">the Scala List API</a>.

   ```scala
   def factorial(n: Int): Int = {
     /* Todo: Implement the factorial function */
   }
   
   /* Compute the sum of the factorials in the list */
   val totalFactorial = /* Todo: Implement */
   ```

   Solution:

   ```scala
   def factorial(n: Int): Int = {
     if (n==0) 1 else n * factorial(n-1) 
   }
   myNumbers.map(factorial).sum
   // res: Int = 5193
   ```


## Exercise 1: Introduction to the GraphX API

Now that you have learned a little bit about Scala, we can start using GraphX.
First, import the GraphX packages. The `._` at the end of the import statement is a wildcard that tells Scala to import everything in that package, similar to `.*` in Java.

```scala
import org.apache.spark.graphx._
import org.apache.spark.graphx.lib._
import org.apache.spark.rdd.RDD
```

Great! You have now "installed" GraphX.

### The Property Graph
<a name="property_graph"></a>

[PropertyGraph]: http://spark.apache.org/docs/latest/api/graphx/index.html#org.apache.spark.graphx.Graph

The [property graph](PropertyGraph) is a directed multigraph with properties attached to each vertex and edge.
A directed multigraph is a directed graph with potentially multiple parallel edges sharing the same source and destination vertex.
The ability to support parallel edges simplifies modeling scenarios where multiple relationships (e.g., co-worker and friend) can appear between the same vertices.
Each vertex is keyed by a *unique* 64-bit long identifier (`VertexID`).
Similarly, edges have corresponding source and destination vertex identifiers.
The properties are stored as Scala/Java objects with each edge and vertex in the graph.

Throughout the first half of this lab we will use the following toy property graph.
While this is hardly <i>big data</i>, it provides an opportunity to learn about the graph data model and the GraphX API.  In this example we have a small social network with users and their ages modeled as vertices and likes modeled as directed edges.  In this fictional scenario users can like other users multiple times.


<p style="text-align: center;">
  <img src="img/social_graph.png"
       title="Toy Social Network"
       alt="Toy Social Network"
       width="50%" />
  <!-- Images are downsized intentionally to improve quality on retina displays -->
</p>

We begin by creating the property graph from arrays of vertices and edges.
Later we will demonstrate how to load real data.
Paste the following code into the shell.

```scala
val vertexArray = Array(
  (1L, ("Alice", 28)),
  (2L, ("Bob", 27)),
  (3L, ("Charlie", 65)),
  (4L, ("David", 42)),
  (5L, ("Ed", 55)),
  (6L, ("Fran", 50))
  )
val edgeArray = Array(
  Edge(2L, 1L, 7),
  Edge(2L, 4L, 2),
  Edge(3L, 2L, 4),
  Edge(3L, 6L, 3),
  Edge(4L, 1L, 1),
  Edge(5L, 2L, 2),
  Edge(5L, 3L, 8),
  Edge(5L, 6L, 3)
  )
```

In the above example we make use of the `Edge` class. Edges have a `srcId` and a
`dstId` corresponding to the source and destination vertex identifiers. In addition, the [`Edge`][Edge]
class has an `attr` member which stores the edge property (in this case the number of likes).

[Edge]: http://spark.apache.org/docs/latest/api/graphx/index.html#org.apache.spark.graphx.Edge

Using `sc.parallelize` construct the following RDDs from `vertexArray` and `edgeArray`


```scala
val vertexRDD: RDD[(Long, (String, Int))] = sc.parallelize(vertexArray)
val edgeRDD: RDD[Edge[Int]] = /* CODE */
```

In case you get stuck here is the solution.

```scala
val vertexRDD: RDD[(Long, (String, Int))] = sc.parallelize(vertexArray)
val edgeRDD: RDD[Edge[Int]] = sc.parallelize(edgeArray)
```

Now we are ready to build a property graph.  The basic property graph constructor takes an RDD of vertices (with type `RDD[(VertexId, V)]`) and an RDD of edges (with type `RDD[Edge[E]]`) and builds a graph (with type `Graph[V, E]`).  Try the following:

```scala
val graph: Graph[(String, Int), Int] = Graph(vertexRDD, edgeRDD)
```

The vertex property for this graph is a tuple `(String, Int)` corresponding to the *User Name* and *Age* and the edge property is just an `Int` corresponding to the number of *Likes* in our hypothetical social network.

### Graph Views

In many cases we will want to extract the vertex and edge RDD views of a graph (e.g., when aggregating or saving the result of calculation).
As a consequence, the graph class contains members (`graph.vertices` and `graph.edges`) to access the vertices and edges of the graph.
While these members extend `RDD[(VertexId, V)]` and `RDD[Edge[E]]` they are actually backed by optimized representations that leverage the internal GraphX representation of graph data.

Use `graph.vertices` to display the names of the users that are at least `30` years old.  The output should contain (in addition to lots of log messages):

```bash
David is 42
Fran is 50
Ed is 55
Charlie is 65
```

Here is a hint:

```scala
graph.vertices.filter { case (id, (name, age)) => /* CODE */ }.foreach { case (id, (name, age)) => /* CODE */ }
// To print strings use: println(s"The variable x = ${x.getValue()}")
```

Here are a few solutions:

```scala
graph.vertices.filter { case (id, (name, age)) => age > 30 }.foreach {
  case (id, (name, age)) => println(s"$name is $age")
}
```

In addition to the vertex and edge views of the property graph, GraphX also exposes a triplet view.
The triplet view logically joins the vertex and edge properties yielding an `RDD[EdgeTriplet[VD, ED]]` containing instances of the [`EdgeTriplet`][EdgeTriplet] class. This *join* can be expressed in the following SQL expression:

[EdgeTriplet]: http://spark.apache.org/docs/latest/api/graphx/index.html#org.apache.spark.graphx.EdgeTriplet

```SQL
SELECT src.id, dst.id, src.attr, e.attr, dst.attr
FROM edges AS e LEFT JOIN vertices AS src JOIN vertices AS dst
ON e.srcId = src.Id AND e.dstId = dst.Id
```

or graphically as:

<p style="text-align: center;">
  <img src="img/triplet.png"
       title="Edge Triplet"
       alt="Edge Triplet"
       width="65%" />
  <!-- Images are downsized intentionally to improve quality on retina displays -->
</p>

The `EdgeTriplet` class extends the `Edge` class by adding the `srcAttr` and `dstAttr` members which contain the source and destination properties respectively.


Use the `graph.triplets` view to display who likes who.  The output should look like:

```bash
Bob likes Alice
Bob likes David
Charlie likes Bob
Charlie likes Fran
David likes Alice
Ed likes Bob
Ed likes Charlie
Ed likes Fran
```

Here is a partial solution:

```scala
for (triplet <- graph.triplets) {
 /**
   * Triplet has the following Fields:
   *   triplet.srcAttr: (String, Int) // triplet.srcAttr._1 is the name
   *   triplet.dstAttr: (String, Int)
   *   triplet.attr: Int
   *   triplet.srcId: VertexId
   *   triplet.dstId: VertexId
   */
}
```

Here is the solution:

```scala
graph.triplets.foreach { t =>
  println( s"${t.srcAttr._1} likes ${t.dstAttr._1}")
}
```

If someone likes someone else more than 5 times than that relationship is getting pretty serious.
For extra credit, find the lovers.

```scala
for (triplet <- graph.triplets.filter(t => t.attr > 5)) {
  println( s"${triplet.srcAttr._1} loves ${triplet.dstAttr._1}")
}
```

## Graph Operators

Property graphs also have a collection of basic operations. Here is a link to the [documentation](http://spark.apache.org/docs/latest/api/graphx/index.html#org.apache.spark.graphx.package) for the GraphX API, which details what these operators are and how to use them. In this section you will walk through some of these operators.

For example, we can compute the in-degree of each vertex (defined in [`GraphOps`][GraphOps]) by the following:

[Graph]: http://spark.apache.org/docs/latest/api/graphx/index.html#org.apache.spark.graphx.Graph
[GraphOps]: http://spark.apache.org/docs/latest/api/graphx/index.html#org.apache.spark.graphx.GraphOps

```scala
val inDegrees: VertexRDD[Int] = graph.inDegrees
```

In the above example the `graph.inDegrees` operators returned a `VertexRDD[Int]` (recall that this behaves like `RDD[(VertexId, Int)]`).  What if we wanted to incorporate the in and out degree of each vertex into the vertex property?  To do this we will use a set of common graph operators.

Paste the following code into the Spark shell:

```scala
// Define a class to more clearly model the user property
case class User(name: String, age: Int, inDeg: Int, outDeg: Int)

// Transform the graph
val userGraph = graph.mapVertices{ case (id, (name, age)) => User(name, age, 0, 0) }

// Fill in the degree information
val degreeGraph = userGraph.outerJoinVertices(userGraph.inDegrees) {
  (id, u, inDegOpt) => User(u.name, u.age, inDegOpt.getOrElse(0), u.outDeg)
}.outerJoinVertices(graph.outDegrees) {
  (id, u, outDegOpt) => User(u.name, u.age, u.inDeg, outDegOpt.getOrElse(0))
}
```

Here we use the `outerJoinVertices` method of `Graph` which has the following (confusing) type signature:

```scala
 def outerJoinVertices[U, VD2](other: RDD[(VertexID, U)])
      (mapFunc: (VertexID, VD, Option[U]) => VD2)
    : Graph[VD2, ED]
```

It takes *two* argument lists.
The first contains an `RDD` of vertex values and the second argument list takes a function from the id, attribute, and Optional matching value in the `RDD` to a new vertex value.
Note that it is possible that the input `RDD` may not contain values for some of the vertices in the graph.
In these cases the `Option` argument is empty and `optOutDeg.getOrElse(0)` returns 0.

Print the names of the users who were liked by the same number of people they like.

```scala
degreeGraph.vertices.filter {
  case (id, u) => /* CODE */
}.foreach(println(_))
```

SOLUTION:
```scala
degreeGraph.vertices.filter {
  case (id, u) => u.inDeg == u.outDeg
}.foreach(println(_))
```

### Subgraph

Suppose we want to study the community structure of users that are 30 or older.
To support this type of analysis GraphX includes the [subgraph][Graph.subgraph] operator that takes vertex and edge predicates and returns the graph containing only the vertices that satisfy the vertex predicate (evaluate to true) and edges that satisfy the edge predicate *and connect vertices that satisfy the vertex predicate*.

In the following we restrict our graph to the users that are 30 or older.

[Graph.subgraph]: http://spark.apache.org/docs/latest/api/graphx/index.html#org.apache.spark.graphx.Graph@subgraph((EdgeTriplet[VD,ED])⇒Boolean,(VertexId,VD)⇒Boolean):Graph[VD,ED]

```scala
val olderGraph = userGraph.subgraph(vpred = (id, user) => user.age >= 30)
```

Lets examine the communities in this restricted graph:

```scala
// compute the connected components
val cc = olderGraph.connectedComponents

// display the component id of each user:
olderGraph.vertices.leftJoin(cc.vertices) {
  case (id, user, comp) => s"${user.name} is in component ${comp.get}"
}.collect.foreach{ case (id, str) => println(str) }
```

Connected components are labeled (numbered) by the lowest vertex Id in that component.  Notice that by examining the subgraph we have disconnected David from the rest of his community.  Moreover his connections to the rest of the graph are through younger users.



##Advanced Operators (Optional)

The following section walks through some more advanced graph operators that you will not need to complete the lab. However, if you finish early you should try going through them. But if you want, you can skip to the [next exercise](#football_exercise).

### The Map Reduce Triplets Operator

Using the property graph from Section 2.1, suppose we want to find the oldest follower of each user. The [`mapReduceTriplets`][Graph.mapReduceTriplets] operator allows us to do this. It enables neighborhood aggregation, and its simplified signature is as follows:

[Graph.mapReduceTriplets]: http://spark.apache.org/docs/latest/api/graphx/index.html#org.apache.spark.graphx.Graph@mapReduceTriplets[A](mapFunc:org.apache.spark.graphx.EdgeTriplet[VD,ED]=&gt;Iterator[(org.apache.spark.graphx.VertexId,A)],reduceFunc:(A,A)=&gt;A,activeSetOpt:Option[(org.apache.spark.graphx.VertexRDD[_],org.apache.spark.graphx.EdgeDirection)])(implicitevidence$10:scala.reflect.ClassTag[A]):org.apache.spark.graphx.VertexRDD[A]

```scala
class Graph[VD, ED] {
  def mapReduceTriplets[A](
      map: EdgeTriplet[VD, ED] => Iterator[(VertexId, A)],
      reduce: (A, A) => A): VertexRDD[A]
}
```

The map function is applied to each edge triplet in the graph, yielding messages destined to the adjacent vertices. The reduce function combines messages destined to the same vertex. The operation results in a `VertexRDD` containing an aggregated message for each vertex.

We can find the oldest follower for each user by sending age messages along each edge and aggregating them with the `max` function:

```scala
// Find the oldest follower for each user
val oldestFollower: VertexRDD[(String, Int)] = userGraph.mapReduceTriplets[(String, Int)](
  // For each edge send a message to the destination vertex with the attribute of the source vertex
  edge => Iterator((edge.dstId, (edge.srcAttr.name, edge.srcAttr.age))),
  // To combine messages take the message for the older follower
  (a, b) => if (a._2 > b._2) a else b
  )
  
userGraph.vertices.leftJoin(oldestFollower) { (id, user, optOldestFollower) =>
  optOldestFollower match {
    case None => s"${user.name} does not have any followers."
    case Some((name, age)) => s"${name} is the oldest follower of ${user.name}."
  }
}.foreach { case (id, str) => println(str) }
```

As an exercise, try finding the average follower age for each user instead of the max.

```scala
val averageAge: VertexRDD[Double] = userGraph.mapReduceTriplets[(Int, Double)](
  // map function returns a tuple of (1, Age)
  edge => Iterator((edge.dstId, (1, edge.srcAttr.age.toDouble))),
  // reduce function combines (sumOfFollowers, sumOfAge)
  (a, b) => ((a._1 + b._1), (a._2 + b._2))
  ).mapValues((id, p) => p._2 / p._1)

// Display the results
userGraph.vertices.leftJoin(averageAge) { (id, user, optAverageAge) =>
  optAverageAge match {
    case None => s"${user.name} does not have any followers."
    case Some(avgAge) => s"The average age of ${user.name}\'s followers is $avgAge."
  }
}.foreach { case (id, str) => println(str) }
```



<a name="football_exercise"></a>
## Exercise 2: Using GraphX To Analyze a Real Graph


Now that you have learned about the GraphX API, it's time to look at a graph representing real-world data.
Many real-world graphs are very large and can be hard to analyze on a single machine. 
However, in many cases we are interested in examining only a small portion of the original graph (i.e., a subgraph).
In this exercise, you will be analyzing the Wikipedia link graph, extracted from the raw text of all articles in the English-language Wikipedia corpus.
In this graph, each vertex represents an article in Wikipedia.
There is an edge from Article A to Article B if A has a link to B.
Unfortunatley, the full Wikipedia dataset can be difficult to process on a standard laptop so we used a GraphX cluster to extract the subgraph of articles containing the word "Football" in their title.
It is this subgraph that you will be analyzing today.

Start a new Spark shell so that you can run this exercise in a clean environment. Type `exit` to leave the Spark shell, and then start it again using the same command as before.

```bash
./bin/spark-shell
```

We need to re-import GraphX since we have started a new Spark shell:

```scala
import org.apache.spark.graphx._
import org.apache.spark.graphx.lib._
```

Now load the data from your local filesystem into Spark. The data is in two files - an edge file and a vertex file - located in the `lab10_data` subdirectory of this lab's directory.

To load the edge list, we can use the [`GraphLoader.edgeListFile`][GraphLoader] method, which is a convenient way to create a `Graph` object directly from a file formatted as an edge list (you may need to adjust the path to the file).

[GraphLoader]: http://spark.apache.org/docs/latest/api/graphx/index.html#org.apache.spark.graphx.GraphLoader


```scala
// Change labshome to the appropriate value for your computer
val labshome = "/home/saasbook/datascience-labs/lab10"
val edgeGraph = GraphLoader.edgeListFile(sc, s"${labshome}/lab10_data/edges.txt")
```

This parses the edge list file and creates a `Graph` object. However, this graph doesn't have any vertex properties, so we don't know which vertex corresponds to which article.

The vertex file contains this information. The vertex file is formatted so that the first item on each line is the vertex ID, and the rest of the line is the article title that this vertex corresponds to. We will use Spark to parse the vertex file:

```scala
val verts = sc.textFile(s"${labshome}/lab10_data/verts.txt").map {l =>
  val lineSplits = l.split("\\s+")
  val id = lineSplits(0).trim.toLong
  val data = lineSplits.slice(1, lineSplits.length).mkString(" ")
  (id, data)
}
```

Now that you have loaded the vertex data, join this with the existing graph so that you have a `Graph[String, Int]` that has the relevant vertex properties as part of the object.

```scala
val g = edgeGraph.outerJoinVertices(verts)({ (vid, _, title) => title.getOrElse("xxxx")}).cache
```

Great! Now you have a full graph with all of the properties we are interested in loaded into GraphX, ready to analyze. Let's start by taking a look at some of the basic properties of the graph.

How would you count the number of vertices and edges in the graph (this might be a good time to look back at the GraphX API, or look at the [code itself](https://github.com/apache/spark/blob/branch-0.9/graphx/src/main/scala/org/apache/spark/graphx/Graph.scala)?

```scala
val numEdges = /* CODE */
val numVertices = /* CODE */
```

What is the max in-degree of this graph?

```scala
val maxDegree = g.inDegrees.map{ case (vid, data) => data}.reduce(/* CODE */)
```

SOLUTION
```scala
val maxDegree = g.inDegrees.map{ case (vid, data) => data}.reduce(math.max(_, _))
```

And now look at what some of the triplets look like:

```scala
g.triplets.map(t => s"[${t.srcAttr}] links to [${t.dstAttr}]").take(2)
```

The first analysis we are going to run is PageRank, which should tell us roughly what the most important articles are. We can use the existing PageRank implementation on our graph.

Run Pagerank for 10 iterations:
```scala
val prs = g.staticPageRank(10)
```

That should have returned immediately due to Spark's lazy evaluation. The code won't actually be run until we try to access the results. The simplest way to trigger the execution is to count the results:

```scala
prs.triplets.count
```

This may take a few seconds, depending on your machine.

Notice that the result of running PageRank is another `Graph` object, but this graph has different vertex properties, now they are the PageRank's of each vertex, rather than the article titles. To join the ranks of the vertices with the article titles, we can use `Graph.outerJoinVertices` as we did before.

Go ahead and try this out:

```scala
val ranksAndVertices: Graph[(String, Double), Int] = g.outerJoinVertices(prs.vertices){
  (v, title, r) => /* CODE */
}
```

When we used `outerJoinVertices` to construct our graph, we didn't care about the existing vertex properties, we just replaced them. But in this case, we are joining the rank vertex properties and the title vertex properties into a tuple, keeping both around.

SOLUTION
```scala
val ranksAndVertices = g.outerJoinVertices(prs.vertices){
  (v, title, r) => (r.getOrElse(0.0), title)
}
```

Once you have joined the article titles with their ranks, we can use Spark's `RDD.top()` function to find the top-ranked articles:

```scala
val top10 = ranksAndVertices.vertices.top(10)(Ordering.by((entry: (VertexId, (Double, String))) => entry._2._1)).mkString("\n")
```

Based on the results of running PageRank, what kind of football do you think most of the articles on Wikipedia are about?

PageRank tells us about some of the most important pieces of data in the dataset, but it doesn't tell us much about the overall structure of the data. 
Connected components is a simple algorithm that tells us more about the macroscopic structure.
Your reading mentioned that many real-world graphs have one large connected component, with a few much smaller components.
Let's run connected components on the graph and use the results to determine if your football graph has this property.

```scala
val ccResult = g.connectedComponents()
```

Once again, trigger the actual computation by running count on the results:

```scala
ccResult.triplets.count
```

And finally, let's look at the size of each connected component:

```scala
val ccSizes = ccResult.vertices.map { case (vid, data) => (data, 1) }.reduceByKey(/* CODE */)
ccSizes.map{ case (ccID, size) => size }.collect.sorted
ccResult.vertices.count
```

SOLUTION
```scala
val ccSizes = ccResult.vertices.map { case (vid, data) => (data, 1) }.reduceByKey((_ + _))
ccSizes.map{ case (ccID, size) => size }.collect.sorted
ccResult.vertices.count
```


Does it look like your graph has a single big component?


This brings us to the end of the lab. We encourage you to continue playing
with the code and to check out the [Programming Guide](http://spark.apache.org/docs/latest/graphx-programming-guide.html) for further documentation about the system.


#FAQ
####Where can I find documentation for the GraphX API?####
The scaladocs for GraphX (and the rest of Spark) can be found [here](http://spark.apache.org/docs/latest/api/graphx/index.html#org.apache.spark.graphx.package) on the Spark project website.

