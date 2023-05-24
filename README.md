# Adobe I/O Documentation Template

This is a site template built with the [Adobe I/O Theme](https://github.com/adobe/aio-theme).

View the [demo](https://adobedocs.github.io/dev-site-documentation-template/) running on Github Pages.  

## Where to ask for help

The slack channel #adobeio-onsite-onboarding is our main point of contact for help. Feel free to join the channel and ask any questions.

## How to develop

For local development, simply use :

```shell
$ yarn install
$ yarn dev
```

For the developer documentation, read the following sections on how to:

- [Arrange the structure content of your docs](https://github.com/adobe/aio-theme#content-structure)
- [Link to pages](https://github.com/adobe/aio-theme#links)
- [Use assets](https://github.com/adobe/aio-theme#assets)
- [Set global Navigation](https://github.com/adobe/aio-theme#global-navigation)
- [Set side navigation](https://github.com/adobe/aio-theme#side-navigation)
- [Use content blocks](https://github.com/adobe/aio-theme#jsx-blocks)
- [Use Markdown](https://github.com/adobe/aio-theme#writing-enhanced-markdown)

For more in-depth [instructions](https://github.com/adobe/aio-theme#getting-started).

## How to test

- To run the configured linters locally (requires [Docker](https://www.docker.com/)):

  ```shell
  yarn lint
  ```

  > NOTE If you cannot use Docker, you can install the linters separately. In `.github/super-linter.env`, see which linters are enabled, and find the tools being used for linting in [Supported Linters](https://github.com/github/super-linter#supported-linters).

- To check internal links locally

  ```shell
  yarn test:links
  ```

- To build and preview locally:

  ```shell
  yarn start
  ```

## How to deploy

### Update Links

When moving from stage to prod, links need to be updated:
- Links in `gatsby-config.js` should be moved from `https://main--adobe-io-website--adobe.hlx.page/cpp-docs/events?aio_internal` to `../cpp-docs/events`
- Same is true for links in `src/pages/index.md`
- Update the [nav google
  doc](https://docs.google.com/document/d/1nJMkhBQX23H4k7nhbE8UU44nHgUEfaQV0edKyDSsN58/edit)'s
  links (below product) from `https://developer-stage.adobe.com/cpp` to
  `https://developer.adobe.com/cpp`. Other styled links should change from
  `https://main--adobe-io-website--adobe.hlx.page/cpp-docs/events` to
  `https://developer.adobe.com/cpp-docs/events`

### Deploy Gatsby site

Use the GitHub actions deploy workflow see [deploy
instructions](https://github.com/adobe/aio-theme#deploy-to-azure-storage-static-websites).
