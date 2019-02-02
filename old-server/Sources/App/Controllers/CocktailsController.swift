import Vapor
import HTTP

final class CocktailsController: ResourceRepresentable {
    
    func index(request: Request) throws -> ResponseRepresentable {
        return try Cocktail.all().makeNode().converted(to: JSON.self)
    }

    func create(request: Request) throws -> ResponseRepresentable {
        var cocktail = try request.cocktail()
        try cocktail.save()
        return cocktail
    }

    func show(request: Request, cocktail: Cocktail) throws -> ResponseRepresentable {
        return cocktail
    }

    func delete(request: Request, cocktail: Cocktail) throws -> ResponseRepresentable {
        try cocktail.delete()
        return JSON([:])
    }

    func clear(request: Request) throws -> ResponseRepresentable {
        try Cocktail.query().delete()
        return JSON([])
    }

    func update(request: Request, cocktail: Cocktail) throws -> ResponseRepresentable {
        let new = try request.cocktail()
        var cocktail = cocktail
        cocktail.description = new.description
        try cocktail.save()
        return cocktail
    }

    func replace(request: Request, cocktail: Cocktail) throws -> ResponseRepresentable {
        try cocktail.delete()
        return try create(request: request)
    }

    func makeResource() -> Resource<Cocktail> {
        return Resource(
            index: index,
            store: create,
            show: show,
            replace: replace,
            modify: update,
            destroy: delete,
            clear: clear
        )
    }
}

extension Request {
    func cocktail() throws -> Cocktail {
        guard let json = json else { throw Abort.badRequest }
        return try Cocktail(node: json)
    }
}
