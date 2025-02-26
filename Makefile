GREEN=\033[1;32m
YELLOW=\033[1;33m
RED=\033[1;31m
BLUE=\033[1;34m
NC=\033[0m

all:
	@mkdir -p ~/data/wordpress ~/data/mariadb
	@echo -e "$(BLUE)[+] Starting Docker containers...$(NC)"
	@docker compose -f srcs/docker-compose.yml up --build -d
	@echo -e "$(GREEN)[✔] Containers are running!$(NC)"

clean:
	@echo -e "$(YELLOW)[-] Stopping and removing containers...$(NC)"
	@docker compose -f srcs/docker-compose.yml down -v
	@echo -e "$(GREEN)[✔] Containers stopped and removed.$(NC)"

fclean: clean
	@echo -e "$(RED)[!] Removing volumes and secrets...$(NC)"
	@docker system prune -af --volumes
	@sudo rm -rf ~/data/mariadb ~/data/wordpress
	@echo -e "$(GREEN)[✔] Cleanup complete!$(NC)"

re: fclean all
