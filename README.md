this is an r project for all of my needs related to RASA reporting.

the faculty 180 report 
I now run this report for Pat. its delivered monthly around the 15th. In infoed, the 'current prorpsal status date' field causes crashes, so you have to remove it, run the report, run a separate report with 'Current Proposal Status Date - Recorded Date' (which is the substitute) and institution number only, and then join it back in by institution number
the r script does all of that automatically, with user providing import filenames and desired export filenames. In order to keep award and submission data out of github, the import and export files live outside of the r project folder. ![report repair file structure](https://github.com/user-attachments/assets/14690410-a90d-4567-b5b6-186dbcc93115)
