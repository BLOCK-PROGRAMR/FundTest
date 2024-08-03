-include .env

build:; forge build

deploy-sepolia:; forge script script/FundMe.s.sol:FundmeDeploy --rpc-url $(SEPOLIA_URL) --private-key $(PRIVATE_KEY) --broadcast --verify --etherscan-api-key $(ETHERSCANAPI_KEY) -vvvv