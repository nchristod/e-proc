# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
user = CreateAdminService.new.call
puts 'CREATED ADMIN USER: ' << user.email

Category.create([
  {  name: 'Φαρμακευτικά σκευάσματα', description: 'Οροί, Παυσίπονα, Αντιβιωτικά, κλπ'},
  {  name: 'Χειρουργικά ργαλεία', description: 'Λαβίδες, Νυστέρια, κλπ'},
  {  name: 'Αναλώσιμα Υλικά Χειρουργείων', description: 'Γάζες, σύριγγες, Ράμματα, Αντισηπτικά, Γάντια, Μάσκες, Σκούφοι, κλπ'},
  {  name: 'Ιατρικά Μηχανήματα', description: 'Ακτινολογικά μηχανήματα, Μόνιτορ Ζωτικών λειτουργιών, Καρδιογράφοι, Συσκευές Υποστήριξης Ζωτικών λειτουργιών, κλπ'}
])
puts 'CREATED CATEGORIES'

Product.create([
  {  name: 'Γάζες αντισηπτικές', description: 'Αντισηπτικές Γάζες, εμποτισμένες με σουλφαμίδα, πλάτους 6 cm', category_id: '3'},
  {  name: 'Σύριγγες 5 ml', description: 'Σύριγγες μιας χρήσης, χωρητικότητας 5 ml', category_id: '3'},
  {  name: 'Depon', description: 'Παυσίπονα depon, δισκία', category_id: '1'},
  {  name: 'Γάντια Χειρουργείου', description: 'Χειρουργικά γάντια (ζεύγη) μιας χρήσεως', category_id: '3'},
  {  name: 'Νυστέρια 5 cm', description: 'Χειρουργικά Νυστέρια, 5 cm, μιας χρήσεως', category_id: '2'},
  {  name: 'Φορητός Καρδιογράφος', description: 'Φορητός Καρδιογράφος, 6 απολήξεων', category_id: '4'},
  {  name: 'Σύριγγες 100 ml', description: 'Σύριγγες μιας χρήσεως, χωρητικότητας 100 ml', category_id: '3'}
])
puts 'CREATED PRODUCTS'

10.times { Procurement.create([{
            name: Faker::Lorem.sentence,
            proc_start_date: Faker::Date.between(20.days.ago, 8.days.ago),
            proc_end_date: Faker::Date.forward(2),
            proc_terms: Faker::Lorem.paragraph,
            proc_delivery_date: Faker::Date.forward(30),
            category: rand(0..1),
            user_id: 1}])
          }

# 20.times { ProcurementProduct.create({
#               procurement_id: rand(1..30),
#               product_id: rand(1..7),
#               quantity: rand(1..100),
#               requirements: Faker::Lorem.sentence})
#           }
puts 'CREATED PROCUREMENTS'