<li class="dropdown">
  <%= link_to  "#", class: "dropdown-toggle", id:"dropdownBrochures", role: "button", data: { toggle: "dropdown" } do %>
    eBROCHURES
    <span class="caret"></span>
  <% end %>
  <ul class="dropdown-menu" role="menu" aria-labelledby="dropdownBrochures">
    <li role="presentation"><%= link_to "Brochure Rack", "http://brochurerack.book-my-offer.com/AgentBrochureRack.aspx?arid=ae326916787c60d02f095d8233c27696", role: "menuitem", tabindex: "-1"  %></li>
    <li role="presentation"><%= link_to("Sandals", "http://www.sandals.com/index.cfm?referral=104869", class: "", role: "menuitem", tabindex: "-1" )%></li>
    <li role="presentation"><%= link_to("Beaches Resorts", "http://www.beaches.com/index.cfm?referral=104869", class: "", role: "menuitem", tabindex: "-1" )%></li>
    <li role="presentation"><%= link_to("Grand Pineapple", "http://www.grandpineapple.com/index.cfm?referral=104869", class: "", role: "menuitem", tabindex: "-1" )%></li>
    
  </ul>
</li>