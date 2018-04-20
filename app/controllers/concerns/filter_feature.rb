require_dependency 'Set'
module FilterFeature
  def filter items
    filter_all_actors filter_any_actors filter_director items
  end
  def filter_director items
    if filter_params[:director_id].blank?
      items
    else
      items.select{|item| item[:director_id] == filter_params[:director_id].to_i}
    end
  end
  def filter_any_actors items
    actor_ids = filter_params[:any_actor_ids].reject(&:blank?)
    if actor_ids.blank?
      items
    else
      actor_ids = Set.new(actor_ids.map(&:to_i))
      items.select{|item| Set.new(item.actor_ids).intersect? actor_ids}
    end    
  end
  def filter_all_actors items
    actor_ids = filter_params[:all_actor_ids].reject(&:blank?)
    if actor_ids.blank?
      items
    else
      actor_ids = Set.new(actor_ids.map(&:to_i))
      items.select{|item| actor_ids.subset? Set.new(item.actor_ids)}
    end    
  end
end