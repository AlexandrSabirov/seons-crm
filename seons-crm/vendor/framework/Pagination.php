<?php

namespace framework;


/**
 * Класс Pagination
 */
class Pagination
{
    /**
     * Текущая страница
     * @var int $currentPage
     */
    public int $currentPage;

    /**
     * Количество товара отображаемое на странице
     * @var int $perpage
     */
    public int $perpage;

    /**
     * Общие количество товара
     * @var int $total
     */
    public int $total;

    /**
     * Число страниц
     * @var int $countPages
     */
    public int $countPages;


    /**
     * Ссылка для перехода
     * @var string $uri
     */
    public string $uri;

    /**
     * @access public
     * @param int $page Текущая страница
     * @param int $perpage Количество элементов на странице
     * @param int $total Общие количество элементов
     */
    public function __construct(int $page, int $perpage, int $total)
    {
        $this->perpage = $perpage;
        $this->total = $total;
        $this->countPages = $this->getCountPages();
        $this->currentPage = $this->getCurrentPage($page);
        $this->uri = $this->getParams();
    }

    /**
     * Метод возвращает html разметку пагинации
     */
    public function getHtml()
    {
        $back = null;
        $forward = null;
        $startpage = null;
        $endpage = null;
        $page2left = null;
        $page1left = null;
        $page2right = null;
        $page1right = null;

        if ($this->currentPage > 1) {
            $back = "<li class='page-item'><a class='page-link' href='" . $this->getLink($this->currentPage - 1) . "'>&lt;</a></li>";
        }

        if ($this->currentPage < $this->countPages) {
            $forward = "<li class='page-item'><a class='page-link' href='" . $this->getLink($this->currentPage + 1) . "'>&gt;</a></li>";
        }

        if ($this->currentPage > 3) {
            $startpage = "<li class='page-item'><a class='page-link' href='" . $this->getLink(1) . "'>&laquo;</a></li>";
        }

        if ($this->currentPage < ($this->countPages - 2)) {
            $endpage = "<li class='page-item'><a class='page-link' href='" . $this->getLink($this->countPages) . "'>&raquo;</a></li>";
        }

        if ($this->currentPage - 2 > 0) {
            $page2left = "<li class='page-item'><a class='page-link' href='" . $this->getLink($this->currentPage - 2) . "'>" . ($this->currentPage - 2) . "</a></li>";
        } 

        if ($this->currentPage- 1 > 0) {
            $page1left = "<li class='page-item'><a class='page-link' href='" . $this->getLink($this->currentPage - 1) . "'>" . ($this->currentPage - 1) . "</a></li>";
        }

        if ($this->currentPage + 1 <= $this->countPages) {
            $page1right = "<li class='page-item'><a class='page-link' href='" . $this->getLink($this->currentPage + 1) . "'>" . ($this->currentPage + 1) . "</a></li>";
        }

        if ($this->currentPage + 2 <= $this->countPages) {
            $page2right = "<li class='page-item'><a class='page-link' href='" . $this->getLink($this->currentPage + 2) . "'>" . ($this->currentPage + 2) . "</a></li>";
        }

        return '<nav aria-label="Page navigation example"><ul class="pagination">' . $startpage . $back. $page2left . $page1left . '<li class="page-item active"><a class="page-link">' . $this->currentPage . '</a></li>' . $page1right . $page2right . $forward . $endpage . '</ul></nav>';
    }

    /**
     * Метод получения ссылки для перехода на другую страницу
     * @param int $page
     * @return string
     */
    public function getLink(int $page): string
    {
        if ($page == 1){
            return rtrim($this->uri, '?&');
        }

        if (str_contains($this->uri, '&')){
            return "{$this->uri}page={$page}";
        }else{
            if (str_contains($this->uri, '?')){
                return "{$this->uri}page={$page}";
            }else{
                return "{$this->uri}?page={$page}";
            }
        }
    }

    /**
     * Метод преобразование в строку
     * @return string
     */
    public function __toString()
    {
        return $this->getHtml();
    }

    /**
     * Метод получения общего количества страниц
     * @return int
     */
    public function getCountPages(): int
    {
        return ceil($this->total / $this->perpage) ?: 1;
    }

    /**
     * Метод получения текущей станицы
     * @param int $page
     * @return int
     */
    public function getCurrentPage(int $page): int
    {
        if (!$page || $page < 1) $page = 1;
        if ($page > $this->countPages) $page = $this->countPages;
        return $page;
    }

    /**
     * Метод получения стартовой позиции
     * @return int
     */
    public function getStart(): int 
    {
        return ($this->currentPage - 1) * $this->perpage;
    }

    /**
     * Метод получения uri параметра страницы
     * @return string
     */
    public function getParams(): string
    {
        $url = $_SERVER['REQUEST_URI'];
        $url = explode('?', $url);
        $uri = $url[0];
        if (isset($url[1]) && $url[1] != ''){
            $uri .= '?';
            $params = explode('&', $url[1]);
            foreach ($params as $param) {
                if (!preg_match('#page=#', $param)) $uri .= "{$param}&";
            }
        }
        return $uri;
    }
}
?>