
//Collaborative Filtering
Match(u:User{id:"Taya"})-[s:ISSIMILAR]-(o:User)
With o,u
Order By s.similarity Limit 5
Match(o)-[:LIKES]-(om:Media)
Where Not (u)-[:LIKES]-(om)
Return Distinct om as Media
Skip 0 Limit 5  // For pagination

Union

// Content Based Filtering
MATCH (u:User{id:"Taya"})-[:LIKES]-(m:Media)
WITH collect(m) as mu
UNWIND mu as m
MATCH (m)-[s:ISSIMILAR]-(o:Media)
WHERE NOT o IN mu
WITH o ORDER BY s.similarity DESC
RETURN DISTINCT o as Media
Skip 0 Limit 5  // For pagination