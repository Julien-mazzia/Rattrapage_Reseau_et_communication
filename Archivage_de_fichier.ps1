
param( 
	[String]$repertoire,
	#[String]$recursif,
	[String]$extension,
	[String]$cheminArchive
	
)

$stockage = "c:\stockage"

	If(Test-path $stockage) {Remove-item $stockage -Recurse}
 	New-Item -Path "c:\" -Name "stockage" -ItemType directory
	copy-Item -Path ($repertoire+"\*"+$extension) -destination $stockage -Recurse
	
	If(Test-path $cheminArchive) {Remove-item $cheminArchive -Recurse}
	[io.compression.zipfile]::CreateFromDirectory($stockage, $cheminArchive) 
	
	Remove-Item -path ($repertoire+"\*"+$extension) -Recurse
	$path = $stockage+"\*"+$extension
	$i=@(Dir $path).Count
	Write-Host "Il y a eu $i fichiers archivés"
	
