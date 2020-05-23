import axios from 'axios'

const http = axios.create({
    baseURL: 'http://localhost:3000/users/api'
})


http.interceptors.request.use(function (config) {
    if (localStorage.token) {
        config.headers.Authorization = 'Bearer ' + localStorage.token;
    }
    return config
}, function (error) {
    return Promise.reject(error);
})


http.interceptors.response.use(res => {
    return res;
}, err => {
    if (err.response.data.message) {
        Vue.prototype.$message({
            type: 'error',
            message: err.response.data.message
        });

        if (err.response.status == 401) {
            router.push('/login');
        }
    }
});

export default http 