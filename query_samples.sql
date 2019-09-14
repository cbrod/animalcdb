# Select view_now to see what creatures are available based on the current date/time
SELECT * FROM view_now;

# Select view_now to see the schedules for all creatures in the database
SELECT * FROM view_now;

# Select view_island to see the schedules of the creatures on the island
SELECT * FROM view_island;

# Filter the views to find the schedules for specific creatures
SELECT * FROM animal.view_all WHERE Name LIKE '%beetle%';

# Filter the views to see schedules for a specific type of creature
SELECT * FROM view_now WHERE Type='bug';

# Select into the views to find interesting statistics, such as most valuable creatures
SELECT * FROM animal.view_all ORDER BY Bells DESC LIMIT 25;

# Create a new user
INSERT INTO user VALUES(1 , 'Celeste', 'Celeste is trying to catch them all.');

# Have a user "tag" a creature
INSERT INTO tag VALUES((SELECT creature_id FROM creature WHERE creature_name='scorpion'), 
	(SELECT user_id FROM user WHERE user_name='Celeste'), true, 'This bug as eluded me for years!');

# Pull a list of a user's active tags
SELECT c.creature_name AS Tagged, t.tag_desc AS Notes FROM creature AS c, user AS u, tag AS t
	WHERE c.creature_id = t.creature_id AND u.user_id = t.user_id
	AND u.user_name = 'Celeste' AND t.tag_active = true;

# Add in the view_all view to see the tagged creatures' schedule
SELECT c.creature_name AS Tagged, t.tag_desc AS Notes,
	v.Type, v.Description, v.Bells, v.January, v.February, v.March, v.April, v.May, 
    v.June, v.July, v.August, v.September, v.October, v.November, v.December, v.Island
	FROM creature AS c, user AS u, tag AS t, animal.view_all AS v
	WHERE c.creature_id = t.creature_id AND u.user_id = t.user_id AND u.user_name = 'Celeste'
	AND v.Name = c.creature_name AND t.tag_active = true;

# Deactivate a tag and update its description
UPDATE tag SET tag_active = false, tag_desc='Finally caught a scorpion! Encyclopedia complete!!'
	WHERE user_id = (SELECT user_id FROM user WHERE user_name='Celeste')
	AND creature_id = (SELECT creature_id FROM creature WHERE creature_name='scorpion');