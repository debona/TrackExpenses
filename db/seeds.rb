# This file contains all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

## Banks
#
Bank.create({
  name: 'CIC',
  column_separator: ';',
  date_index: 0,
  value_index: 2,
  title_index: 3
})
Bank.create({
  name: 'Société général',
  column_separator: ';',
  date_index: 0,
  value_index: 3,
  title_index: 2
})

## Categories
#
Category.create([
  { name: Category::UNSORTED_NAME },
  { name: 'Withdraw' },
  { name: 'Classic shopping' },
  { name: 'Public transport' },
  { name: 'Trip' },
  { name: 'Health' },
  { name: 'Phone & Net' },
  { name: "Flat's rent" },
  { name: 'Restaurant' },
  { name: 'Geek stuff' },
  { name: 'Girl stuff' },
  { name: 'Gift' },
  { name: 'Man clothings' },
  { name: 'Woman clothings' },
  { name: 'Whisky' }
])
