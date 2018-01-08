db.createCollection('customers');
db.customers.find().pretty();
db.customers.update({first_name:"John"}, {first_name:"John", last_name:"Doe", gender:"male"});
db.customers.update({first_name:"Steven"}, {$set:{gender:"male"}});
db.customers.update({first_name:"Steven"}, {$inc:{age:5}});
db.customers.update({first_name:"Steven"}, {$unset:{age:1}});
db.customers.update({first_name:"Mary"}, {first_name:"Mary", last_name:"Samson"},{upsert: true});
db.customers.update({first_name:"Steven"}, {$rename: {"gender":"sex"}});
db.customers.remove({first_name:"Steven"});
db.customers.remove({first_name:"Steven"}, {justOne:true});
db.customers.find({first_name:"Sharon"});
db.customers.find({$or: [{first_name:"Sharon"},{first_name:"Troy"}] });
db.customers.find({age:{$lt: 40}}).pretty();
db.customers.find({"address.city":"Boston"}).pretty();
db.customers.find({memberships:"mem1"}).pretty();
db.customers.find().sort({last_name:1});
db.customers.find().count();
db.customers.find({gender:"male"}).count();
db.customers.find.limit(4);
db.customers.find().forEach(function(doc){print("Customer Name: " + doc.first_name)});



db.createUser({
	user:"nurul",
	pwd:"1234",
	roles: ["readWrite", "dbAdmin"]
});

db.customers.insert([
	{
		first_name : "Troy",
		last_name : "Makons",
		gender : "male",
		age : 33,
		address : {
			street : "432 Essex st",
			city : "Lawrence",
			state : "MA"
		},
		memberships : ["mem1", "mem2"],
		balance : 125.32
	},
	{
		first_name : "Beth",
		last_name : "Jenkins",
		gender : "female",
		age : 23,
		address : {
			street : "411 Blue st",
			city : "Boston",
			state : "MA"
		},
		memberships : ["mem2", "mem3"],
		balance : 505.33
	},
	{
		first_name : "Sharon",
		last_name : "Thompson",
		gender : "female",
		age : 35,
		address : {
			street : "19 Willis st",
			city : "Worchester",
			state : "MA"
		},
		memberships : ["mem1", "mem2"],
		balance : 99.99
	},
	{
		first_name : "William",
		last_name : "Jackson",
		gender : "male",
		age : 43,
		address : {
			street : "11 Albany st",
			city : "Boston",
			state : "MA"
		},
		memberships : ["mem1"],
		balance : 333.23
	},
	{
		first_name : "Timothy",
		last_name : "Wilkins",
		gender : "male",
		age : 53,
		address : {
			street : "22 School st",
			city : "Amesbury",
			state : "MA"
		},
		memberships : ["mem3", "mem4"],
		balance : 22.25
	}
]);
