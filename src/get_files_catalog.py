import re
import requests
from bs4 import BeautifulSoup
import pandas as pd

# Month mapping from Spanish to numeric (01-12)
MONTHS = {
    'enero': '01', 'febrero': '02', 'marzo': '03', 'abril': '04',
    'mayo': '05', 'junio': '06', 'julio': '07', 'agosto': '08',
    'septiembre': '09', 'setiembre': '09', 'octubre': '10',
    'noviembre': '11', 'diciembre': '12',
    'ene': '01', 'feb': '02', 'mar': '03', 'abr': '04',
    'may': '05', 'jun': '06', 'jul': '07', 'ago': '08',
    'sep': '09', 'oct': '10', 'nov': '11', 'dic': '12'
}

def extract_date(filename):
    filename = filename.lower()

    patterns = [
        r'(\d{4})[-_](\d{2})',
        r'(\d{4})[-_](\w{3,9})',
        r'ecobici[_-](\d{4})[_-](\w+)',
        r'datos[_]?abiertos[_-]?(\d{4})[_-]?(\w+)'
    ]

    for pattern in patterns:
        match = re.search(pattern, filename)
        if match:
            year, month = match.groups()
            month = MONTHS.get(month, month)
            return int(year), int(month) if month.isdigit() else None

    return None, None

def get_csv_links():
    base_url = 'https://ecobici.cdmx.gob.mx/datos-abiertos/'
    response = requests.get(base_url)
    soup = BeautifulSoup(response.text, 'html.parser')

    links = []
    for a in soup.find_all('a', href=True):
        if '.csv' in a['href']:
            link = a['href']
            if not link.startswith('http'):
                link = 'https://datos.cdmx.gob.mx' + link
            links.append(link)
    return links

def build_dataframe(links):
    rows = []
    for url in links:
        filename = url.split('/')[-1]
        year, month = extract_date(filename)
        if year and month:
            rows.append({'year': year, 'month': month, 'url': url})
    return pd.DataFrame(rows)

# Entry point for manual execution
if __name__ == "__main__":
    links = get_csv_links()
    df = build_dataframe(links)
    
    # Sort the dataframe by year and month descending
    df_sorted = df.sort_values(['year', 'month'], ascending=False)

    # Save to CSV
    output_path = "../opt/catalog.csv"
    df_sorted.to_csv(output_path, index=False)
    print(f"Catalog saved to {output_path} with {len(df_sorted)} entries.")