# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# Replaced functionality with cocoon gem
# $(document).ready ->
#   $("#add_row").on "click", ->
    
#     # Dynamic Rows Code
    
#     # Get max row id and set new id
#     newid = 0
#     $.each $("#table1 tbody tr"), ->
#       newid = parseInt($(this).data("id"))  if parseInt($(this).data("id")) > newid
#       return

#     newid++
#     tr = $("<tr></tr>",
#       id: "row" + newid
#       "data-id": newid
#     )
    
#     # loop through each td and create new elements with name of newid
#     $.each $("#table1 tbody tr:nth(0) td"), ->
#       cur_td = $(this)
#       children = cur_td.children()
      
#       # add new td and element if it has a nane
#       if $(this).data("name")?
#         td = $("<td></td>",
#           "data-name": $(cur_td).data("name")
#         )
#         c = $(cur_td).find($(children[0]).prop("tagName")).clone().val("")
#         c.attr "id", "procurement_procurement_products_attributes_" + newid + "_" + $(cur_td).data("name")
#         c.attr "name", "procurement[procurement_products_attributes][" + newid + "][" + $(cur_td).data("name") + "]"
#         c.appendTo $(td)
#         td.appendTo $(tr)
#       else
#         td = $("<td></td>",
#           text: $("#table1 tr").length
#         ).appendTo($(tr))
#       return

    
#     # add delete button and td
#     #
#     #        $("<td></td>").append(
#     #            $("<button class='btn btn-danger glyphicon glyphicon-remove row-remove'></button>")
#     #                .click(function() {
#     #                    $(this).closest("tr").remove();
#     #                })
#     #        ).appendTo($(tr));
#     #        
    
#     # add the new row
#     $(tr).appendTo $("#table1")
#     $(tr).find("td button.row-remove").on "click", ->
#       $(this).closest("tr").remove()
#       return

#     return
