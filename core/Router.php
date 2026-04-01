<?php
/**
 * Router - Enrutador de solicitudes
 */
class Router {
    private array $routes = [];
    
    public function get(string $path, string $controller, string $method): void {
        $this->addRoute('GET', $path, $controller, $method);
    }
    
    public function post(string $path, string $controller, string $method): void {
        $this->addRoute('POST', $path, $controller, $method);
    }
    
    private function addRoute(string $httpMethod, string $path, string $controller, string $method): void {
        $this->routes[] = [
            'method' => $httpMethod,
            'path' => $path,
            'controller' => $controller,
            'action' => $method
        ];
    }
    
    public function dispatch(string $uri, string $method): void {
        // Remove query string
        $uri = parse_url($uri, PHP_URL_PATH);
        $uri = rtrim($uri, '/');
        
        foreach ($this->routes as $route) {
            if ($route['method'] !== strtoupper($method)) {
                continue;
            }
            
            // Simple pattern matching
            $pattern = preg_replace('/\{([a-z]+)\}/', '([^/]+)', $route['path']);
            $pattern = "#^{$pattern}$#";
            
            if (preg_match($pattern, $uri, $matches)) {
                array_shift($matches); // Remove full match
                
                $controllerClass = $route['controller'];
                $action = $route['action'];
                
                if (class_exists($controllerClass)) {
                    $controller = new $controllerClass();
                    if (method_exists($controller, $action)) {
                        call_user_func_array([$controller, $action], $matches);
                        return;
                    }
                }
            }
        }
        
        // 404 Not Found
        http_response_code(404);
        require __DIR__ . '/../views/errors/404.php';
    }
}
