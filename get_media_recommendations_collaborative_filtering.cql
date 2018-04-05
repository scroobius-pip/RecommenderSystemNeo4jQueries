Match(u:User{id:"Dorian"})-[s:ISSIMILAR]-(o:User)
With o,u
Order By s.similarity Limit 5
Match(o)-[:LIKES]-(om:Media)
Where Not (u)-[:LIKES]-(om)
Return Distinct om
