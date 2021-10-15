@page{
       margin-left: 1cm;
    margin-right: 1cm;
    margin-top: 2cm;
    margin-bottom: 2cm;
    @top-center {
    }
    @bottom-left {
        content: element(footer);
    }
}

@page :first {
    @top-center {
        content: element(header);
    }
    @bottom-left {
 content: element(footer);
    }
}


div.header {
    padding: 8px;
    position: running(header);
    text-align: center;
}

div.footer {
    padding: 5px;
    position: running(footer);
}

.pagenumber:before {
    content: counter(page);
}

.pagecount:after {
    content: counter(pages);
}


div.breakafter {
  page-break-after: always;
}

	
ul{
        margin-Top : 0;
	margin-bottom:;
	padding-left: 8px;

}