# Combat Robotics

<img src="ROBOT_COMBAT_DB.png">

## Successful Queries:
Most queries were successful. Almost all of them gave accurate and consice answers.

Question: "What are the best performing robots in each weight class? What kind of bots are they?"

Answer: "The best-performing robots in each weight class and their types are as follows:

- Fairyweight 150g: Phalanx, a 2WD fork wedge bot with 21 ranking points.
- Plastic Antweight 1lb: WedgeMe, a durable wedge with 25 ranking points.
- Beetleweight 3lb: War Drum, a double weapon bot with 35 ranking points.
- Beetleweight 3lb: Orbit, a 4WD Beater Bar with a self-righting arm and a 4140 hardened steel spinner, also with 35 ranking points."

## Unsuccessful Query:
When the query results were zero, instead of answering "there were no robots" or "no teams matched that description", ChatGPT seemed to be confused. Even when I explicitly told it in the instruction line "If the query result is blank, it is not by mistake. That was the query result", it still was confused as to what to do. This happened when using both a zero shot approach, and a single domain double shot approach.

### Zero Shot
Question: "Which teams have less than three robots?"

Answer: "The query result is blank."

### Single Domain Double Shot
Question: "How many robots have greater than 60 rating points?"

Answer: "There were no results for the given query."

## Zero Shot vs Single Domain Double Shot
I did not notice a difference between the results. They both gave accurate results except for when the query results were blank.
This was surprising to me, because with the Single Domain Double Shot, I gave it an example of what to say if no results were given.
*For example: for an empty SQL Result table, user question: "Which teams don't have any robots", the response could be "No teams had 0 robots"*
