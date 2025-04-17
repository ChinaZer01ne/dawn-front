# 使用多阶段构建：减小镜像体积，分离构建环境和运行环境
# 阶段1：构建环境（包含所有构建工具）
FROM node:18-alpine AS builder

# 设置工作目录
WORKDIR /app

# 优先单独复制 package.json 利用缓存
COPY package*.json ./
RUN npm ci --production  # 生产环境仅安装必要依赖

# 复制源码并构建
COPY . .
RUN npm run build

# 阶段2：生产环境（仅保留运行所需的最小内容）
FROM nginx:1.25-alpine

# 复制 Nginx 配置文件（即使与默认配置相同，用于兜底）
COPY nginx.conf /etc/nginx/conf.d/default.conf

# 从构建阶段复制产物
COPY --from=builder /app/dist /usr/share/nginx/html

# 暴露端口
EXPOSE 80

# 启动命令
CMD ["nginx", "-g", "daemon off;"]