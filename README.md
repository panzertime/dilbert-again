# A viewer for Dilbert cartoons.

I got an archive of Dilbert comics, mostly as GIFs, from the [Internet Archive](https://archive.org/details/dilbert-1989-2023-complete.-7z_202303) and needed a viewer. I used the tools in `utils` to rename all the files to just an ISO-8601 date, and then if you can statically host those, it's easy to use a Javascript frontend (`index.html`) to look at them. I used an S3 bucket for my copy, you can use whatever you like for yourself.

There's a live demo at [Dilbert Website 2000](https://dilbert.transglobal.world).

# A Slack bot for Dilbert cartoons.

You can send an archive image to a Slack webhook every day using the bundled `webhook_doer.py` script. Use a cron job or systemd timer to run it every morning.
