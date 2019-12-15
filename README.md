# Kubernetes Microservices Demo

Three simple apps in this repo:

**books**

To keep things simple, we don't really have a database of books.
For whatever request that is made to the `/api/v1/book/:id` endpoint, we always return a same book.

**auth**

It will check the authorization token.
If it matches `SUPERSECUREAUTTHTOKEN`, then it returns `{ok: true}`;
otherwise, it returns `{ok: false}`.

**gateway**

`/api/v1/book/:bookId` validates the authentication the request by forwarding a request to **auth**.
If it is authenticated, it will then make a request to **books** asking for details for the book given the `bookId `.

## Running services inside a minikube cluster

Build docker images for the docker daemon inside minikube.
And then create kubenete deployment and service.

```
./ops/build.sh
./ops/start.sh
```
Start script will expose the service url. You can request on ```${books-service-url:port}/api/v1/books/1``` to test the application.

### Testing gateway service
```
curl $(minikube service gateway-service --url)/api/v1/book/1 -H "authorization: SUPERSECUREAUTTHTOKEN"

{
  "book_id": "1",
  "title": "An Absolutely Remarkable Thing",
  "auther": "Hank Green",
  "published_date": "2019-12-15"
}
```