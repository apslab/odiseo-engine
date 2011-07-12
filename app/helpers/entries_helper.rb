module EntriesHelper
  def options_from_entry_for_select(entry)
    entry.exercise.accounts.leaves.map{|a|[[a.code, a.name].compact.join(' &raquo; ').html_safe, a.id]}
  end
end
