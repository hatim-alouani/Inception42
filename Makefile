GREEN=\033[1;32m
YELLOW=\033[1;33m
RED=\033[1;31m
BLUE=\033[1;34m
NC=\033[0m

all:
	@mkdir -p /home/haalouan/data/wordpress /home/haalouan/data/mariadb
	@echo -e "$(BLUE)[+] Starting Docker containers...$(NC)"
	@docker-compose -f srcs/docker-compose.yml up --build
	@echo -e "$(GREEN)[✔] Containers are running!$(NC)"

clean:
	@echo -e "$(YELLOW)[-] Stopping and removing containers...$(NC)"
	@docker-compose -f srcs/docker-compose.yml down -v
	@echo -e "$(GREEN)[✔] Containers stopped and removed.$(NC)"
	@echo -e "$(RED)[!] Removing volumes...$(NC)"
	@docker system prune -af --volumes
	@sudo rm -rf /home/haalouan/data/mariadb /home/haalouan/data/wordpress
	@echo -e "$(GREEN)[✔] Cleanup complete!$(NC)"

re: clean all
