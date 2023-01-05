-------- QUERY --------

select 
	m.name as "Model",
	b.name as "Brand",
	ag.name as "Automotive Group",
	o.date_order as "Purchase date",
	c.number_plate as "Number plate",
	c2.name as "Colour",
	max(i2.km_total) as "Total Km",
	i.name as "Insurance",
	pc.id_policy as "Policy number"
from fatima_ramirez_simon.automotive_group ag
join fatima_ramirez_simon.brand b on ag.id_group = b.id_group
join fatima_ramirez_simon.models m on m.id_brand = b.id_brand
join fatima_ramirez_simon.cars c on c.id_model = m.id_model
join fatima_ramirez_simon.colours c2 on c2.id_colour = c.id_colour
join fatima_ramirez_simon.orders o on o.id_order = c.id_order
join fatima_ramirez_simon.policy_car pc on pc.number_plate = c.number_plate 
join fatima_ramirez_simon.insurance i on i.id_insurance = pc.id_insurance 
join fatima_ramirez_simon.inspections i2 on i2.number_plate = c.number_plate
group by ag.name, b.name, m.name, c2.name, c.number_plate, o.date_order, i.name, pc.id_policy
order by "Brand" asc;
