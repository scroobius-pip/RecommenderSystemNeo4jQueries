Match(u:User{id:"Dorian"})-[:LIKES]-(m:Media)
WITH collect(m) as mu
UNWIND mu as m
Match(m)-[s:ISSIMILAR]-(o:Media)
WHERE NOT o in mu
RETURN DISTINCT o,s ORDER BY  s.similarity DESC LIMIT 10