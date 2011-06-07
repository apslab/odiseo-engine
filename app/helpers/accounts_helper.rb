module AccountsHelper
  def draw_tree_item_for_account(account)
    div_for(account) do
      [account.label_html,
        link_to(icon('add'), new_account_account_url(account), :rel => '#overlay', :class => 'overlay-handler', :style => 'text-decoration:none'),
        link_to(icon('application_delete'), account, :confirm => 'borrar', :method => :delete),
        link_to(icon('application_edit'), edit_account_url(account), :rel => '#overlay', :class => 'overlay-handler', :style => 'text-decoration:none'),
        (account.leaf?) ? link_to(icon('report_go'), new_account_report_url(account), :style => 'text-decoration:none') : nil
      ].compact.join(' ').html_safe
    end
  end
end

