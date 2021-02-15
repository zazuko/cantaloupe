# Cantaloupe

This is a non-official Docker image for [Cantaloupe](https://cantaloupe-project.github.io/).

## Quick Start

### Setup

Run the following command:

```sh
docker-compose up
```

Go to http://localhost:9000, and log in using following informations:

- Access Key: `minio`
- Secret Key: `password`

Create the following buckets: `cache` and `images`.

Upload some files in the `images` bucket, for example a big image called `big.jpg`.

Go to http://localhost:8182/iiif/2/big.jpg/info.json to see some informations about this image.
You can replace `big.jpg` with the name of your image.

### View image

You can now try to view the image.

For that, you can use https://digital.bodleian.ox.ac.uk/manifest-editor/.

Click on the new `New Manifest` button.

At the bottom, you will have to click on `Add Canvas`, then click on the canvas that just got created, called `Empty canvas`, to select it.

Click on the `Canvas Metadata` tab on the right, then on the `Add Image to Canvas` button.

Select `From info.json URI`, paste the info.json URL from the last step of the [Setup](#Setup) part and click on the submit button.

You will now be able to see your image.

### Teardown

```
docker-compose down
```
