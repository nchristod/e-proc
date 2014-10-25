atom_feed do |feed|
  feed.title("Listing Active Procurements")
  feed.updated(@procurements[0].created_at) if @procurements.length > 0

  @procurements.each do |procurement|
    feed.entry(procurement) do |entry|
      entry.title(procurement.name)
      entry.content(procurement.proc_terms, type: 'html')

      entry.author do |author|
        author.name("MyCompany")
      end
    end
  end
end