<template>
  <div class="form-container">
    <h2>提交表单</h2>
    <form @submit.prevent="submitForm">
      <div class="form-group">
        <label for="name">姓名:</label>
        <input type="text" id="name" v-model="formData.name" required>
      </div>
      <div class="form-group">
        <label for="email">邮箱:</label>
        <input type="email" id="email" v-model="formData.email" required>
      </div>
      <div class="form-group">
        <label for="message">留言:</label>
        <textarea id="message" v-model="formData.message" rows="4" required></textarea>
      </div>
      <button type="submit" class="submit-btn">提交</button>
    </form>
  </div>
</template>

<script>
export default {
  data() {
    return {
      formData: {
        name: '',
        email: '',
        message: ''
      }
    }
  },
  methods: {
    async submitForm() {
      try {
        // 发送POST请求到后端接口
        const response = await fetch('/api/submit', {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json'
          },
          body: JSON.stringify(this.formData)
        });

        if (!response.ok) {
          throw new Error('提交失败');
        }

        // 提交成功后的处理
        alert('提交成功！');
        this.resetForm();
      } catch (error) {
        console.error('提交失败:', error);
        alert('提交失败，请重试。');
      }
    },
    resetForm() {
      this.formData = {
        name: '',
        email: '',
        message: ''
      };
    }
  }
}
</script>

<style scoped>
.form-container {
  max-width: 500px;
  margin: 2rem auto;
  padding: 2rem;
  background-color: #f5f5f5;
  border-radius: 8px;
  box-shadow: 0 0 10px rgba(0,0,0,0.1);
}

.form-group {
  margin-bottom: 1.5rem;
}

label {
  display: block;
  margin-bottom: 0.5rem;
  font-weight: bold;
}

input, textarea {
  width: 100%;
  padding: 0.5rem;
  border: 1px solid #ddd;
  border-radius: 4px;
  box-sizing: border-box;
}

.submit-btn {
  background-color: #42b983;
  color: white;
  padding: 0.8rem 1.5rem;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  font-size: 1rem;
  transition: background-color 0.3s;
}

.submit-btn:hover {
  background-color: #3aa876;
}
</style>