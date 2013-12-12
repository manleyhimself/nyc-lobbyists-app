
# **Inconsistencies
# ___________
# Office of The Mayor (OTM)

# Mayor, Office of the (OTM)

# Mayor's Office
# ________
# Health And Mental Hygiene, Department of (DOHMH)


# The Department of Health And Mental Hygiene (DOHMH)

# DOHMH

# __________
# Sanitation, Department of (DSNY)

# _______
# Transportation, Department of (DOT)

# __________
# Economic Development Corporation, NYC (NYCEDC)

# _____
# Education, Department of

["mayor's office", "mayor", "office of the (otm)", "the department of health and mental hygiene", "(dohmh)", "health and mental hygiene", "department of (dohmh)", "dohmh", "sanitation", "department of (dsny)", "transportation", "department of (dot)", "economic development corporation", "nyc (nycedc)", "education", "department of"]

if element.include?("mayor") || element.include?("otm")
  element = "Office of the Mayor" 
elsif element.include?("dohmh") || element.include?("mental hygiene")
  element = "Department of Mental Hygiene" 
elsif element.include?("dsny") || element.include?("sanitation")
  element = "Department of Sanitation" 
elsif element.include?("(dot)") || element.include?("transportation") || element == "dot"
  element = "Department of Transportation"
elsif element.include?("nycedc") || element.include?("economic development")
  element = "NYCEDC"
elsif element == "department of"
  element = nil
elsif element.include?("education")
  element = "Department of Education"
else
  element
end


