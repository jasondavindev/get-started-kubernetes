import express from 'express';
import * as request from "request-promise";

const app = express();
const port = 8080;

app.get("/api/v1/book/:id", async (req: express.Request, res: express.Response) => {
  const headers = { headers: { Authorization: req.get('Authorization') }};
  try {
    await request.get('http://auth-service.default.svc.cluster.local', headers);
    const book = await request.get(`http://books-service.default.svc.cluster.local/api/v1/book/${req.params.id}`);
    res.send(book)
  } catch (error) {
    res.status(403).send("Access denied");
  }
});

app.listen(port, () => console.log(`Listening on port ${port}!`));
