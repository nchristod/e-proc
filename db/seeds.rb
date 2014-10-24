# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
user = CreateAdminService.new.call
puts 'CREATED ADMIN USER: ' << user.email

categories = Category.create([
  {  name: 'Φαρμακευτικά σκευάσματα', description: 'Οροί, Παυσίπονα, Αντιβιωτικά, κλπ'},
  {  name: 'Χειρουργικά ργαλεία', description: 'Λαβίδες, Νυστέρια, κλπ'},
  {  name: 'Αναλώσιμα Υλικά Χειρουργείων', description: 'Γάζες, σύριγγες, Ράμματα, Αντισηπτικά, Γάντια, Μάσκες, Σκούφοι, κλπ'},
  {  name: 'Ιατρικά Μηχανήματα', description: 'Ακτινολογικά μηχανήματα, Μόνιτορ Ζωτικών λειτουργιών, Καρδιογράφοι, Συσκευές Υποστήριξης Ζωτικών λειτουργιών, κλπ'}
])

prpoducts = Product.create([
  {  name: 'Γάζες αντισηπτικές', description: 'Αντισηπτικές Γάζες, εμποτισμένες με σουλφαμίδα, πλάτους 6 cm', category_id: '3'},
  {  name: 'Σύριγγες 5 ml', description: 'Σύριγγες μιας χρήσης, χωρητικότητας 5 ml', category_id: '3'},
  {  name: 'Depon', description: 'Παυσίπονα depon, δισκία', category_id: '1'},
  {  name: 'Γάντια Χειρουργείου', description: 'Χειρουργικά γάντια (ζεύγη) μιας χρήσεως', category_id: '3'},
  {  name: 'Νυστέρια 5 cm', description: 'Χειρουργικά Νυστέρια, 5 cm, μιας χρήσεως', category_id: '2'},
  {  name: 'Φορητός Καρδιογράφος', description: 'Φορητός Καρδιογράφος, 6 απολήξεων', category_id: '4'},
  {  name: 'Σύριγγες 100 ml', description: 'Σύριγγες μιας χρήσεως, χωρητικότητας 100 ml', category_id: '3'}
])