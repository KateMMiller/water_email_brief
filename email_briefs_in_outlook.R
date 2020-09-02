#RDCOMClient not setup for R 4.x yet. Here's the workaround:
# dir <- tempdir()
# zip <- file.path(dir, "RDCOMClient.zip")
# url <- "https://github.com/dkyleward/RDCOMClient/releases/download/v0.94/RDCOMClient_binary.zip"
# download.file(url, zip)
# install.packages(zip, repos = NULL, type = "win.binary")

library(RDCOMClient)
library(htmltools) # for includeHTML
library(KeyboardSimulator) # for keybd.press

rmarkdown::render("water_brief_word.Rmd", "word_document")
rmarkdown::render("water_brief_html.Rmd", "html_document")

word_file <- paste(getwd(), "water_brief_word.docx", sep = "/")
htmlbody <- paste(includeHTML('water_brief_html.html'))

# # Open Outlook
outlook <- COMCreate("Outlook.Application")

# Create a new message
email = outlook$CreateItem(0)

# Set the recipient, subject, and body
email[["to"]] = paste("kathryn_miller@nps.gov", "kate_m_miller@hotmail.com", sep=";")
email[["SentOnBehalfOfName"]] = "kathryn_miller@nps.gov"
#email[["cc"]] = paste("kathryn_miller@nps.gov", sep=";")
email[["bcc"]] = ""
email[["subject"]] = "NETN water brief"
email[["htmlbody"]] = paste(htmlbody)
email[["attachments"]]$Add(word_file)

# Open separate window in Outlook to view email before sending
email$Display()
# To send the email directly in R, run lines below
Sys.sleep(3)
keybd.press('Ctrl+Enter')

