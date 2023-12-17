use leetcode;

--QUESTION

--Each node in the tree can be one of three types:

--"Leaf": if the node is a leaf node.
--"Root": if the node is the root of the tree.
--"Inner": If the node is neither a leaf node nor a root node.

--Write a solution to report the type of each node in the tree.


/*
Tree table: Input Table
+----+------+
| id | p_id |
+----+------+
| 1  | null |
| 2  | 1    |
| 3  | 1    |
| 4  | 2    |
| 5  | 2    |
+----+------+

Output: 
+----+-------+
| id | type  |
+----+-------+
| 1  | Root  |
| 2  | Inner |
| 3  | Leaf  |
| 4  | Leaf  |
| 5  | Leaf  |
+----+-------+
*/

/*
CREATE TABLE tree(
id int,
p_id int
)

insert into tree(id, p_id)
values(1,null),
(2,1),
(3,1),
(4,2),
(5,2)
*/

select * from tree;



with t1 as
(
select t1.id as node, t1.p_id as parent_node
		,t2.id as child_node
from tree t1 left join tree t2
on t1.id = t2.p_id
), t2 as
(
select node, parent_node, child_node,
		case when parent_node is null then 'Root'
				when parent_node is not null and child_node is not null then 'Inner'
				when child_node is null then 'Leaf'
				end as type
from t1
)

select distinct node as n, type from t2


--method 2

select Employee, 
		case when Manager is null then 'Root'
				when Manager is not null and 
					Employee in (select distinct Manager from new_tree) then 'Inner'
				else 'Leaf'
				end as Node_Type
from new_tree