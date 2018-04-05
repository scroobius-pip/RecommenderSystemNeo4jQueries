
//Collaborative Filtering
Match(u:User{id:"Dorian"})-[s:ISSIMILAR]-(o:User)
With o,u
Order By s.similarity Limit 5
Match(o)-[:LIKES]-(om:Media)
Where Not (u)-[:LIKES]-(om)
Return Distinct om as Media

Union

// Content Based Filtering
Match(u:User{id:"Dorian"})-[:LIKES]-(m:Media)
WITH collect(m) as mu
UNWIND mu as m
Match(m)-[s:ISSIMILAR]-(o:Media)
WHERE NOT o in mu
With o,s
ORDER BY  s.similarity DESC LIMIT 10
Return o as Media