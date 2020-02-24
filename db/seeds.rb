# here is where I will create some seed data to work with and test associations

# create 2 users:

indre = User.create(name:"Indre", email:"indre@bakeer.com", password:"password")
john = User.create(name:"John", email:"john@smith.com", password:"password")

# create goals:
# use AR to pre-associate date:

indres_goal = indre.goals.create(title: "Finish coding bootcamp", description: "Make sure to finish coding bootcamp on time and have fun while doing it")

johns_goal = john.goals.create(title: "travel internationally", description: "Go anywhere in Europe this summer")



