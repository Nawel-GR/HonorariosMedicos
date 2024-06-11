

def parse_date(date):
    '''
    Parse date in format dd/mm/yyyy to YYMMDD
    '''
    date = date.split("/")
    return date[2][2:] + date[1] + date[0]

assert parse_date("01/01/2021") == "210101"

def parse_date_2(date):
    """
    parse date in format Miércoles 12/10/2022 al Miércoles 12/10/2022 to YYMMDD
    """
    date = date.split(" ")
    date = date[1].split("/")
    return date[2][2:] + date[1] + date[0]

assert parse_date_2("Miércoles 12/10/2022 al Miércoles 12/10/2022") == "221012"
