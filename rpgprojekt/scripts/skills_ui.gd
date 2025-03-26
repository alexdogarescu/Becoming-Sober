extends MenuButton

func add_skills_on_popup(skills: Array):
	for skill in skills:
		get_popup().add_item(skill.name)
