User.create!(user_name: 'Will', password: 'secret')
User.create!(user_name: 'Matt', password: 'asdfasdf')

Cat.create!(name: "Sennacy", age: "7", birth_date: "01/01/2007",
           color: "Orange", sex: "F", user_id: User.first.id)
Cat.create!(name: "Rocky", age: "8", birth_date: "14/05/2006",
          color: "Black", sex: "M", user_id: User.first.id)
Cat.create!(name: "Isis", age: "7", birth_date: "05/03/2007",
          color: "Orange", sex: "F", user_id: User.last.id)
Cat.create!(name: "Jonathan", age: "20", birth_date: "26/05/1994",
          color: "Blue", sex: "M", user_id: User.first.id)
Cat.create!(name: "Roo", age: "11", birth_date: "01/06/2003",
          color: "Brown", sex: "F", user_id: User.last.id)