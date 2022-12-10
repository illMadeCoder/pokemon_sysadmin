{
    id:.[0].id,
    name:.[0].name,
    types:[.[0].types[].type.name],
    flavor_text:.[1].flavor_text_entries[2].flavor_text | sub("\n";" ") | sub("\f";" ")
}
