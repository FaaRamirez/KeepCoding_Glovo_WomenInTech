-------- QUERY --------

select 
	c.model as "Model",
	b.name as "Brand",
	ag.name as "Automotive Group",
	o.date_order as "Purchase date",
	c.number_plate as "Number plate",
	c2.name as "Colour",
	max(i2.km_total) as "Total Km",
	i.name as "Insurance",
	pc.id_policy as "Policy number"
from kcvehicles.automotive_group ag  
join kcvehicles.brand b on ag.id_group = b.id_group
join kcvehicles.cars c on c.id_brand = b.id_brand
join kcvehicles.colours c2 on c2.id_colour = c.id_colour
join kcvehicles.orders o on o.id_order = c.id_order
join kcvehicles.policy_car pc on pc.number_plate = c.number_plate 
join kcvehicles.insurance i on i.id_insurance = pc.id_insurance 
join kcvehicles.inspections i2 on i2.number_plate = c.number_plate
group by ag.name, b.name, c.model, c2.name, c.number_plate, o.date_order, i.name, pc.id_policy
order by "Brand" asc;