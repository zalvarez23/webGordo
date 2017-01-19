<?php

// if you want to find the root path of a folder use the line of code below:
//echo $_SERVER['DOCUMENT_ROOT']


if ($_FILES["file"]["error"] > 0){
echo "Error Code: " . $_FILES["file"]["error"] . "<br />";
}
else
{
echo "Uploaded file: " . $_FILES["file"]["name"] . "<br />";
echo "Type: " . $_FILES["file"]["type"] . "<br />";
echo "Size: " . ($_FILES["file"]["size"] / 1024) . " kilobytes<br />";

if (file_exists("/files/".$_FILES["file"]["name"]))
  {
  echo $_FILES["file"]["name"] . " already exists. No joke-- this error is almost <i><b>impossible</b></i> to get. Try again, I bet 1 million dollars it won't ever happen again.";
  }
else
  {
  move_uploaded_file($_FILES["file"]["tmp_name"],"img/".$_FILES["file"]["name"]);
  echo "Done";
  }
}
?>