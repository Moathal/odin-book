module ReactHelper
  def react(component, props = {}, tag_name = :div)
    content_tag tag_name, nil, data: { controller: "react", react: { component: component, props: props.to_json } }
  end
end