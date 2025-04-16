<template>
  <div id="app">
    <h1>{{ message }}</h1>
    <button @click="count++">Clicked {{ count }} times</button>
    <h1>Vue 3 表单提交示例</h1>
    <Form />
  </div>

</template>

<script>
export default {
  components: {
    Form
  },
  data() {
    return {
      message: "Vue 3 运行成功! 🎉",
      count: 0
    }
  }
}

import Form from './components/Form.vue'

</script>
