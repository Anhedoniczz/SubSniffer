# Subdomain Finder and Filter Script

This script automates the process of discovering subdomains for a given domain and then filters them using the `httpx-toolkit` to check for live subdomains. The final output is saved in a file named after the domain, which contains the list of valid live subdomains (excluding duplicates and those ending with numbers).

## Requirements

The following tools need to be installed for the script to work:

- **`assetfinder`**: A subdomain discovery tool.
- **`subfinder`**: Another subdomain discovery tool.
- **`httpx-toolkit`**: A tool to check if subdomains are alive and accessible on specific ports.

You can install these tools using the following commands:

```bash
# Install assetfinder
go install github.com/tomnomnom/assetfinder@latest

# Install subfinder
go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest

# Install httpx-toolkit
sudo apt-get install httpx-toolkit
```
## Usage
Run the script by providing a domain as an argument. The domain will be used to search for subdomains, which will then be filtered for live subdomains. The final output will be saved in a file named after the domain.
### Command Syntax:
```
./SubSniffer.sh -u <domain>
```
### Example:
```
./SubSniffer.sh -u example.com
```

### Steps:

- Use assetfinder to find subdomains related to example.com.
- Use subfinder to find additional subdomains for the domain.
- Merge and deduplicate the subdomains.
- Use httpx-toolkit to check for live subdomains on common ports (80, 443, 8000, 8080, 8888).
- Filter out any subdomains that end with numbers.
- Save the final list of valid live subdomains to a file named example.com.

## File Structure
The script creates the following:

- Final output: A file named after the domain (e.g., ```example.com```) containing the list of live, valid subdomains.
## Notes
- The script assumes that the required tools are installed and available in the system's $PATH.
- The list of live subdomains is checked only on ports 80, 443, 8000, 8080, and 8888. You can modify the port list in the script if needed.
- The script excludes subdomains ending with numbers from the final output.
  
