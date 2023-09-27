/*
 * Copyright 2020 Adobe. All rights reserved.
 * This file is licensed to you under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License. You may obtain a copy
 * of the License at http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software distributed under
 * the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR REPRESENTATIONS
 * OF ANY KIND, either express or implied. See the License for the specific language
 * governing permissions and limitations under the License.
 */

module.exports = {
  pathPrefix: process.env.PATH_PREFIX || '/cpp/',
  siteMetadata: {
    pages: [
      {
        title: 'C++ at Adobe',
        path: '/'
      },
      /*{
        title: 'Whitepapers',
        path: '/whitepapers/'
      },*/
      {
        title: 'Events',
        path: '../cpp-docs/events?aio_internal'
      },
      {
        title: 'Blog',
        path: 'https://blog.developer.adobe.com/tagged/cpp-at-adobe?aio_internal'
      },
      {
        title: 'Training',
        path: '/training/'
      },
      {
        title: 'Careers',
        path: '../cpp-docs/careers?aio_internal'
      },
      {
        title: 'Teams',
        path: '../cpp-docs/teams?aio_internal'
      }
    ],
    subPages: []
  },
  plugins: [`@adobe/gatsby-theme-aio`]
};
