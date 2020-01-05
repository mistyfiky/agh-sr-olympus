MATCH (n)
WITH n LIMIT 10000
OPTIONAL MATCH (n)-[r]->()
DELETE n,r;

CREATE CONSTRAINT ON (g:Genre) ASSERT g.id IS UNIQUE;

LOAD CSV WITH HEADERS FROM "file:///genre_node.csv" AS r FIELDTERMINATOR ';'
CREATE (g:Genre {
  id: toInteger(r.`id:ID(Genre)`),
  name: r.name
});

CREATE CONSTRAINT ON (k:Keyword) ASSERT k.id IS UNIQUE;

LOAD CSV WITH HEADERS FROM "file:///keyword_node.csv" AS r FIELDTERMINATOR ';'
CREATE (k:Keyword {
  id: toInteger(r.`id:ID(Keyword)`),
  name: r.name
});

CREATE CONSTRAINT ON (m:Movie) ASSERT m.id IS UNIQUE;

LOAD CSV WITH HEADERS FROM "file:///movie_node.csv" AS r FIELDTERMINATOR ';'
CREATE (m:Movie {
  id: toInteger(r.`id:ID(Movie)`),
  title: r.title,
  tagline: r.tagline,
  summary: r.summary,
  poster_image: r.poster_image,
  duration: toInteger(r.`duration:int`),
  rated: r.rated
});

CREATE CONSTRAINT ON (p:Person) ASSERT p.id IS UNIQUE;

LOAD CSV WITH HEADERS FROM "file:///person_node.csv" AS r FIELDTERMINATOR ';'
CREATE (p:Person {
  id: toInteger(r.`id:ID(Person)`),
  name: r.name,
  born: toInteger(r.`born:int`),
  poster_image: r.poster_image
});

LOAD CSV WITH HEADERS FROM "file:///has_genre_rels.csv" AS r FIELDTERMINATOR ';'
MATCH (m:Movie {id: toInteger(r.`:START_ID(Movie)`)}), (g:Genre {id: toInteger(r.`:END_ID(Genre)`)})
CREATE (m)-[:HAS_GENRE]->(g);

LOAD CSV WITH HEADERS FROM "file:///has_keyword_rels.csv" AS r FIELDTERMINATOR ';'
MATCH (m:Movie {id: toInteger(r.`:START_ID(Movie)`)}), (k:Keyword {id: toInteger(r.`:END_ID(Keyword)`)})
CREATE (m)-[:HAS_KEYWORD]->(k);

LOAD CSV WITH HEADERS FROM "file:///writer_of_rels.csv" AS r FIELDTERMINATOR ';'
MATCH (p:Person {id: toInteger(r.`:START_ID(Person)`)}), (m:Movie {id: toInteger(r.`:END_ID(Movie)`)})
CREATE (p)-[:WRITER_OF]->(m);

LOAD CSV WITH HEADERS FROM "file:///produced_rels.csv" AS r FIELDTERMINATOR ';'
MATCH (p:Person {id: toInteger(r.`:START_ID(Person)`)}), (m:Movie {id: toInteger(r.`:END_ID(Movie)`)})
CREATE (p)-[:PRODUCED]->(m);

LOAD CSV WITH HEADERS FROM "file:///directed_rels.csv" AS r FIELDTERMINATOR ';'
MATCH (p:Person {id: toInteger(r.`:START_ID(Person)`)}), (m:Movie {id: toInteger(r.`:END_ID(Movie)`)})
CREATE (p)-[:DIRECTED]->(m);

LOAD CSV WITH HEADERS FROM "file:///acted_in_rels.csv" AS r FIELDTERMINATOR ';'
MATCH (p:Person {id: toInteger(r.`:START_ID(Person)`)}), (m:Movie {id: toInteger(r.`:END_ID(Movie)`)})
CREATE (p)-[:ACTED_IN{role:SPLIT(r.role, '/')}]->(m);

