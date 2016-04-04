# Rush Hour

[![Code Climate](https://codeclimate.com/github/jwashke/rush-hour/badges/gpa.svg)](https://codeclimate.com/github/jwashke/rush-hour)[![Code Climate](https://codeclimate.com/github/jwashke/rush-hour/badges/gpa.svg)](https://codeclimate.com/github/jwashke/rush-hour)[![Issue Count](https://codeclimate.com/github/jwashke/rush-hour/badges/issue_count.svg)](https://codeclimate.com/github/jwashke/rush-hour)[![Build Status](https://travis-ci.org/jwashke/rush-hour.svg?branch=master)](https://travis-ci.org/jwashke/rush-hour)

Rush Hour is a simple analytics platform to analyze http requests received by a website.

## Installation

To use, git clone the repository and then run the server using the command shotgun or rackup from the root project directory

## Usage

To view the site visit
```
http://localhost:port/
```

to register a client send a curl request with an identifier parameter and rootUrl parameter to

```
http://localhost:port/sources
```
ex
```
curl -i -d 'identifier=jumpstartlab&rootUrl=http://jumpstartlab.com'  http://localhost:9393/sources
```

send payloads to the site by sending a curl request to
```
http://localhost:port/sources/IDENTIFER/data
```
use parameters formatted as the example below
```
curl -i -d 'payload={"url":"http://jumpstartlab.com/blog","requestedAt":"2013-02-16 21:38:28 -0700","respondedIn":37,"referredBy":"http://jumpstartlab.com","requestType":"GET","parameters":[],"eventName":"socialLogin","userAgent":"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17","resolutionWidth":"1920","resolutionHeight":"1280","ip":"63.29.38.211"}' http://localhost:9393/sources/jumpstartlab/data

```

to view the aggregate client data go to
```
http://localhost:port/sources/IDENTIFIER
```

to view stats for a specific url visit
```
http://yourapplication:port/sources/IDENTIFER/urls/RELATIVEPATH
```

to view stats for a specific event visit
```
http://localhost:port/sources/IDENTIFIER/events/EVENTNAME
```

or to view an index of all events for a site visit
```
http://localhost:port/IDENTIFIER/index/events
```


## Contributing

1. Fork it!
2. Create your feature branch: `git checkout -b my-new-feature`
3. Commit your changes: `git commit -am 'Add some feature'`
4. Push to the branch: `git push origin my-new-feature`
5. Submit a pull request :D
