/client/verb/whitelist_app()
	set name = "Apply to Whitelist"
	set desc = "Write an application to server's whitelist"
	set category = "Special Verbs"

	if(!config.prisonlist_enabled)
		to_chat(src, "<span class='warning'>Whitelist disabled in config.</span>")
		return 0

	if(is_in_whitelist())
		to_chat(src, "<span class='warning'>You already listed in whitelist!</span>")
		return 0

	whitelist_app_window()

/client/proc/whitelist_app_window()
	var/output = {"<div>
	������� �� ��� ������� � SS13?<br>
	<a href='?_src_=holder;firstquestion=\ref[src]'>������</A><br>
	��� ������ �� ���?<br>
	<a href='?_src_=holder;secondquestion=\ref[src]'>������</A><br>
	��� �����, ��� �� ������������� �� ���� � ��� ���������� � �������� ����??<br>
	<a href='?_src_=holder;thirdquestion=\ref[src]'>������</A><br>
	���� � ������ ������� ������<br>
	<a href='?_src_=holder;forthquestion=\ref[src]'>������</A><br>
	��� �������<br>
	<a href='?_src_=holder;fifthquestion=\ref[src]'>������</A><br>
	���� � ��� ���� � �������, ����������, �����������������?<br>
	<a href='?_src_=holder;sixthquestion=\ref[src]'>������</A><br>
	������ �� �� ���� �� ������ ��������? (���� ����� ����� ��������, ������� � ����� ��������� �������� ������)<br>
	<a href='?_src_=holder;seventhquestion=\ref[src]'>������</A><br>
	<a href='?_src_=holder;eighthquestion=\ref[src]'>������</A><br>
	<a href='?_src_=holder;ninethquestion=\ref[src]'>������</A><br>
	<a href='?_src_=holder;submit=\ref[src]'>������</A></div>
	"}
	var/datum/browser/popup = new(usr, "secrets", "<div align='center'>Whitelist Panel</div>", 900, 500)
	popup.set_content(output)
	popup.open(0)
