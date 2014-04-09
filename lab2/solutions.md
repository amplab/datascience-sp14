* How many rows are present in `log_df` ? What are the URLs between rows 85 and 90 ?

```
log_df.count()
log_df.iloc[85:90,].URL

```


* Lab 1 Deja vu ! Use selection to print the number of requests that had HTTP
  return code 404. How many of them were on 30th April and how many on 1st May ?
  Hint: Use the `multi_grouped` DataFrame we created above.

```
log_df[log_df['ResponseCode'] == 404].count()
multi_grouped.get_group((404.0, '01/May/1998')).count()
multi_grouped.get_group((404.0, '30/Apr/1998')).count()
```

* Create a new column that contains the ResponseSize in kilo bytes.

```
log_df["ResponseSizeKB"] = log_df.apply(lambda row: row["Size"]/1024.0, axis=1)
```

* What is the average file size for images (.gif or .jpg or .jpeg files) which
had response code 200 ? What is the standard deviation ?

```
    ok_url_sizes = log_df[log_df['ResponseCode'] == 200][['URL', 'Size']]
    img_urls =  ok_url_sizes[ok_url_sizes.apply(lambda row: ".gif" in row['URL']
or ".jpeg" in row['URL'] or ".jpg" in row['URL'], axis=1)]
    img_urls['Size'].mean()
    img_urls['Size'].std()
```

* Generate a histogram of traffic to the site every *half-hour* and plot this.

```
    half_hour_grouped = log_df.groupby(lambda row: pd.to_datetime(str(log_df['DateTime'][row].hour) + ":" +
str((log_df['DateTime'][row].minute / 30)*30)))
    half_hour_grouped.size().plot()
```
