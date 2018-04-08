MATCH (u:User{id:"Dorian"})-[:LIKES]-(m:Media)
WITH collect(m) as mu
UNWIND mu as m
MATCH (m)-[s:ISSIMILAR]-(o:Media)
WHERE NOT o IN mu
WITH o ORDER BY s.similarity DESC
RETURN DISTINCT o;