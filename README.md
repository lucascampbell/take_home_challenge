# Problem

We need to clearance inventory from time to time.  Certain items don't sell through to our clients, so every month, we collect certain unsold items and
sell them to a third party for a portion of their wholesale price.

# Vocab

_Items_ refer to individual pieces of clothing.  So, if we have two of the exact same type of jeans, we have two items.  Items are grouped by _style_, so
the two aforementioned items would have the same style.

Important data about an item is:

* size
* color
* status - sellable, not sellable, sold, clearanced
* price sold
* date sold

A style's important data is:

* wholesale price
* retail price
* type - pants, shirts, dresses, skirts, other
* name

# Requirements

We want an application to handle this clearance task.   The user will scan or enter item ids into a spreadsheet and upload it into the application each
month.

Specifically:

* receive a spreadsheet of item ids bound for clearance
* update those item's status to "clearanced"
* record the price sold and date sold
* the price sold should be 75% of the wholesale price
* A report is produced to give to the vendor about what they just bought

Validations:
- sold items should not be clearanced
- Pants and dresses should never be sold for less than $5 (but must be sold)
- All other items should never be sold for less than $2 (but must be sold)

Input format
- The spreadsheet will be in CSV
- Item IDs will be in the first column
- All clearanced items for the month will be in one CSV

Tech Specs:
- Rails 4.1
- Ruby 2.1
- SQLite or Postgres preferred, MySQL OK
- Anything can be changed if you think it's needed, including database schema, Rails config, whatever

